#!/usr/bin/env python3
"""
Manufacturing Data Engine (MDE) configuration export tool.

Usage:

    python3 mdeutil.py export --directory . \
        --url http://localhost --port 8080
"""

import argparse
import json
import logging
import os
from typing import Dict, List, Union
from urllib.request import Request, urlopen
from urllib.parse import urlencode

logging.basicConfig(
    level=logging.INFO,
    format='[%(asctime)s] {%(pathname)s:%(lineno)d} %(levelname)s - %(message)s',
    datefmt='%H:%M:%S'
)


# Data classes
class File():
    def __init__(self, filename: str, content: Union[dict, list]) -> None:
        self.filename = filename
        self.content = content

    def export(self) -> None:
        with open(self.filename, 'w') as f:
            f.write(json.dumps(self.content, indent=4))


# Global functions
def process_schema_to_buckets(bucket_schemas: List[File]) -> List[File]:
    output = []
    for schemas in bucket_schemas:
        filename = schemas.filename
        content = schemas.content
        if isinstance(content, list):
            schema_list = content
        else:
            schema_list = content['schemas']
        for s in schema_list:
            s.pop('id')
            s['schema'].pop('id')
            bucket_name = s["bucketName"]
            schema_name = s["schema"]["name"]
            new_filename = f'{schema_name}_to_{bucket_name}.json'
            path_tokens = filename.split('/')
            path_tokens[-1] = new_filename
            output.append(File(filename='/'.join(path_tokens), content=s))
    return output


def process_metadata_instances(files: List[File]) -> List[File]:
    output = []
    for f in files:
        filename = f.filename
        metadata_instance = f.content
        if isinstance(metadata_instance, list):
            output.append(f)
            continue
        metadata = metadata_instance['metadata']
        if len(metadata) == 0:
            output.append(f)
            continue
        else:
            metadata_buckets = metadata_instance['metadataBuckets']
            metadata_registry = metadata['registry']
            metadata_list = []
            for b in metadata_buckets:
                reg = metadata_registry[b]
                # Reconstructing metadata instances without 'id' field
                reg = [{k: v for k, v in r.items() if k != 'id'} for r in reg]
                metadata_list += reg
            output.append(File(filename=filename, content=metadata_list))
    return output


# Global variables
CONFIG_ENDPOINTS = {
    'buckets': '/api/v1/metadata/bucket',
    'metadata_instances': '/api/v1/tags',
    'parsers': '/api/v1/pipelines',
    'payloads': '/api/v1/payloads',
    'schemas': '/api/v1/schema',
    'schema_to_buckets': '/api/v1/metadata/bucket',
    'tags': '/api/v1/tags',
    'types': '/api/v1/types',
}
CONFIG_MAP = {
    'default': {
        'name': None,
    },
    'buckets': {
        'name': None,
        'schemas': [],
        'version': 1,
        'permissive': None,
    },
    'metadata_instances': {
        'metadata': None,
        'metadataBuckets': None,
    },
    'parsers': {
        'name': None,
        'payloadName': None,
        'typeName': None,
        'mapper': None,
        'enabled': None,
    },
    'payloads': {
        'name': None,
        'expression': None,
        'priority': None,
    },
    'schemas': {
        'schemaId': None,
        'name': None,
        'provider': None,
        'value': None,
        'description': None,
    },
    'schema_to_buckets': {
        'schemas': None,
    },
    'tags': {
        'name': None,
        'archetypeName': None,
        'typeName': None,
        'payloadSpecification': None,
        'metadata': {},
        'metadataBuckets': [],
        'storageSpecification': None,
    },
    'types': {
        'name': None,
        'archetype': None,
        'storageSpecification': None,
        'payloadSpecification': None,
        'permissive': None
    },
}
CONFIG_PROCESSING = {
    'schema_to_buckets': process_schema_to_buckets,
    'metadata_instances': process_metadata_instances,
}


class MdeClient():
    def __init__(self, url: str, port: str) -> None:
        self.base_url = url
        self.port = port

    def get_config(self, type: str) -> list:
        if type == 'tags' or type == 'metadata_instances':
            tags = self._http_get(CONFIG_ENDPOINTS[type])
            if isinstance(tags, list):
                return tags
            else:
                return tags['tags']

        return self._http_get(CONFIG_ENDPOINTS[type])

    def _http_get(self, endpoint: str) -> Union[list, dict]:
        url = f'{self.base_url}:{self.port}{endpoint}'
        req = Request(
            url=url,
            method='GET'
        )
        logging.info(f'Making GET request to "{url}"')
        with urlopen(req) as resp:
            response_data = json.loads(resp.read().decode("utf-8"))
            return response_data


class MdeExporter():
    def __init__(self, url: str, port: str) -> None:
        self.client = MdeClient(url=url, port=port)

    def export_all(self, base_dir: str) -> None:
        config_types = list(CONFIG_ENDPOINTS.keys())
        logging.info(f'Exporting MDE configs: {config_types}')
        for ct in config_types:
            path = f'{base_dir}/{ct}'
            os.makedirs(path, exist_ok=True)
            self._export_config(type=ct, directory=path)

    def _export_config(self, type: str, directory: str) -> None:
        logging.info(f'Exporting {type} to {directory}')

        type_map = self._get_type_map(type=type)
        configs = self.client.get_config(type=type)
        file_configs: List[File] = [
            File(filename=f'{directory}/{c.get("name", c["id"])}.json', content=c)
            for c in configs
        ]
        file_configs = [
            File(filename=f.filename,
                 content=self._map_config(config=f.content, config_map=type_map)
                 )
            for f in file_configs
        ]
        if type in CONFIG_PROCESSING:
            processing_func = CONFIG_PROCESSING[type]
            file_configs = processing_func(file_configs)

        for f in file_configs:
            f.export()

    def _map_config(self, config: dict, config_map: dict) -> dict:
        output = {}
        for k, v in config.items():
            if k in config_map:
                if config_map[k] == None:
                    output[k] = v
                else:
                    output[k] = config_map[k]
        return output

    def _get_type_map(self, type: str = 'default') -> dict:
        return CONFIG_MAP.get(type, CONFIG_MAP['default'])


def main(args):
    logging.info(f'Arguments: {args}')

    op = args.op
    type = args.type
    base_dir = args.directory
    port = args.port
    url = args.url

    # TODO: Argument validation
    if not os.path.isdir(base_dir):
        raise ValueError(f'{base_dir} is not a directory')

    exporter = MdeExporter(url=url, port=port)

    if type == 'all':
        exporter.export_all(base_dir=base_dir)
    else:
        raise NotImplementedError(
            f'Type "{type}" not supported.'
            f'Only "all" type is supported.'
        )

    logging.info('Done!')


if __name__ == '__main__':
    """ This is executed when run from the command line """
    parser = argparse.ArgumentParser()

    parser.add_argument(
        'op',
        choices=['export'],
        help='mdeutil operation type'
    )

    parser.add_argument(
        '-d',
        '--directory',
        action='store',
        dest='directory',
        required=True,
        help='Output directory'
    )

    parser.add_argument(
        '-p',
        '--port',
        action='store',
        dest='port',
        required=True,
        help='Config manager port'
    )

    parser.add_argument(
        '-t',
        '--type',
        action='store',
        dest='type',
        choices=['all'],
        default='all',
        help='MDE config type'
    )

    parser.add_argument(
        '-u',
        '--url',
        action='store',
        dest='url',
        required=True,
        help='Config manager base URL'
    )

    args = parser.parse_args()
    main(args)
