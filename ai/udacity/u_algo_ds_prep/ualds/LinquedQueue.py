
import unittest
import os
import Empty
import copy

class LinkedQueue:
    """FIFO  queue iplementation using a sngly linked list for storage"""
    #---------------nested class ----------------------------------------
    class _Node:
        def __init__(self,element, next=None):
            self._element = element
            self._next = next

    #----------------- stack methods ------------------------------------

    def __init__(self):

        self._head = None
        self._tail = None
        self._size = 0

    def __len__(self):
        return self._size

    def is_empty(self):
        return self._size == 0

    def first(self):
        """return a head element without modifying the list
            return error if list is empty
        """
        if self.is_empty():
            raise Empty("Stack is empty")
        return self._head._element

    def dequeue(self):
        """remove and return the first element of the queue"""

        if self.is_empty():
            raise Empty("Stack is empty")
        answer = self._head._element
        self._head = self._head._next
        self._size -= 1
        if self.is_empty():
            self._tail = None
        return answer

    def enqueue(self, e):
        newest = self._Node(e, None)
        if self.is_empty():
            self._head = newest
        else:
            self._tail._next = newest
        self._tail = newest
        self._size += 1


class LinkedQueueTest(unittest.TestCase):
    def setUp(self):
        self._queue_e0 = LinkedQueue()

        self._queue_e2 = LinkedQueue()
        self._queue_e2.enqueue("one")
        self._queue_e2.enqueue("two")


    def tearDown(self):
        pass

    def test_emptyStack(self):
        """check empty queuee"""
        q = copy.deepcopy(self._queue_e0)
        self.assertTrue(q.is_empty())

    def test_enqueue(self):
        q = copy.deepcopy(self._queue_e0)
        q.enqueue("one")
        self.assertEqual(q.first(), "one")
        q.enqueue("two")
        self.assertEqual(len(q),2)

    def test_dequeue(self):
        q = copy.deepcopy(self._queue_e2)
        res = q.dequeue()
        self.assertEqual(res, "one")
        self.assertEqual(len(q),1)


if __name__ == '__main__':
    unittest.main()


