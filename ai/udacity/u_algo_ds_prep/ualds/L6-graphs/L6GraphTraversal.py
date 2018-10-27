class Node(object):
    def __init__(self, value):
        self._value = value
        self._edges = []
        self._visited = False

class Edge(object):
    def __init__(self, value, node_from, node_to):
        self._value = value
        self._node_from = node_from
        self._node_to = node_to



