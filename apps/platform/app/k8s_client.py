from kubernetes import client, config

try:
    config.load_incluster_config()
except:
    config.load_kube_config()

v1 = client.CoreV1Api()
apps_v1 = client.AppsV1Api()


def get_nodes():
    nodes = v1.list_node().items

    result = []

    for node in nodes:
        result.append({
            "name": node.metadata.name,
            "status": node.status.conditions[-1].type,
            "kubelet": node.status.node_info.kubelet_version,
            "os": node.status.node_info.os_image,
        })

    return result


def get_pods():
    pods = v1.list_pod_for_all_namespaces().items

    return {
        "total": len(pods),
        "running": len([p for p in pods if p.status.phase == "Running"]),
        "failed": len([p for p in pods if p.status.phase == "Failed"]),
    }


def get_namespaces():
    namespaces = v1.list_namespace().items

    return [ns.metadata.name for ns in namespaces]
