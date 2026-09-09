"""Structures LeetCode hands you but never defines in runnable form.

Builders accept LeetCode's own array notation so you can paste an example
straight out of the problem statement into a test.
"""
from __future__ import annotations


class ListNode:
    def __init__(self, val: int = 0, next: "ListNode | None" = None):
        self.val = val
        self.next = next

    @staticmethod
    def of(*vals: int) -> "ListNode | None":
        head = None
        for v in reversed(vals):
            head = ListNode(v, head)
        return head

    def to_list(self) -> list[int]:
        out, node = [], self
        while node:
            out.append(node.val)
            node = node.next
        return out

    def __repr__(self) -> str:
        return f"ListNode({self.to_list()})"


class TreeNode:
    def __init__(self, val: int = 0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

    @staticmethod
    def from_level_order(vals: list[int | None]) -> "TreeNode | None":
        """Build from LeetCode's level-order form, e.g. [3,9,20,None,None,15,7]."""
        if not vals or vals[0] is None:
            return None
        root = TreeNode(vals[0])
        queue, i = [root], 1
        while queue and i < len(vals):
            node = queue.pop(0)
            if i < len(vals):
                if vals[i] is not None:
                    node.left = TreeNode(vals[i])
                    queue.append(node.left)
                i += 1
            if i < len(vals):
                if vals[i] is not None:
                    node.right = TreeNode(vals[i])
                    queue.append(node.right)
                i += 1
        return root

    def to_level_order(self) -> list[int | None]:
        out: list[int | None] = []
        queue = [self]
        while queue:
            node = queue.pop(0)
            if node is None:
                out.append(None)
                continue
            out.append(node.val)
            queue.extend([node.left, node.right])
        while out and out[-1] is None:
            out.pop()
        return out

    def __repr__(self) -> str:
        return f"TreeNode({self.to_level_order()})"
