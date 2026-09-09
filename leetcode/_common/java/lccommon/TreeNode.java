package lccommon;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.Deque;
import java.util.List;

public class TreeNode {
    public int val;
    public TreeNode left;
    public TreeNode right;

    public TreeNode() {}
    public TreeNode(int val) { this.val = val; }
    public TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val; this.left = left; this.right = right;
    }

    /** Build from LeetCode's level-order form, e.g. fromLevelOrder(3,9,20,null,null,15,7). */
    public static TreeNode fromLevelOrder(Integer... vals) {
        if (vals.length == 0 || vals[0] == null) return null;
        TreeNode root = new TreeNode(vals[0]);
        Deque<TreeNode> queue = new ArrayDeque<>();
        queue.add(root);
        int i = 1;
        while (!queue.isEmpty() && i < vals.length) {
            TreeNode node = queue.poll();
            if (i < vals.length) {
                if (vals[i] != null) { node.left = new TreeNode(vals[i]); queue.add(node.left); }
                i++;
            }
            if (i < vals.length) {
                if (vals[i] != null) { node.right = new TreeNode(vals[i]); queue.add(node.right); }
                i++;
            }
        }
        return root;
    }

    public List<Integer> toLevelOrder() {
        List<Integer> out = new ArrayList<>();
        Deque<TreeNode> queue = new ArrayDeque<>();
        queue.add(this);
        while (!queue.isEmpty()) {
            TreeNode n = queue.poll();
            if (n == null) { out.add(null); continue; }
            out.add(n.val);
            queue.add(n.left);
            queue.add(n.right);
        }
        while (!out.isEmpty() && out.get(out.size() - 1) == null) out.remove(out.size() - 1);
        return out;
    }

    @Override public String toString() { return "TreeNode" + toLevelOrder(); }
}
