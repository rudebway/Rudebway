#!/usr/bin/env python3
from ipaddress import IPv4Network
from random import randint, choice
from string import ascii_uppercase, ascii_lowercase, digits
from argparse import ArgumentParser


def random_mac():
    mac = [
        0x52, 0x54, 0x00,
        randint(0x00, 0x7f),
        randint(0x00, 0xff),
        randint(0x00, 0xff)
    ]
    return ':'.join(map(lambda x: "%02x" % x, mac))


def random_password(size: int = 12):
    chars = ascii_uppercase + ascii_lowercase + digits
    return ''.join(choice(chars) for x in range(size))


def gen_name(network: IPv4Network, name: str = 'cortes', index: int = 0):
    for ip in network:
        if ip == network.network_address or ip == network.broadcast_address or ip == network[1]:
            continue
        yield str(ip), f'{name}{index}', random_password(), random_mac()
        index += 1


def _parser():
    parser = ArgumentParser()
    parser.add_argument(dest='network', type=IPv4Network, help='network ip')
    parser.add_argument('-n', '--name', dest='name', default='cortes', type=str, help='vpn main name')
    parser.add_argument('-i', '--index', dest='index', default=0, type=int, help='start name index')
    return vars(parser.parse_args())


def main():
    for ip, name, password, mac in gen_name(**_parser()):
        print(ip, name, password, mac)


if __name__ == '__main__':
    main()
