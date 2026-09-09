package lccommon;

import java.util.ArrayList;
import java.util.List;

public class ListNode {
    public int val;
    public ListNode next;

    public ListNode() {}
    public ListNode(int val) { this.val = val; }
    public ListNode(int val, ListNode next) { this.val = val; this.next = next; }

    public static ListNode of(int... vals) {
        ListNode head = null;
        for (int i = vals.length - 1; i >= 0; i--) head = new ListNode(vals[i], head);
        return head;
    }

    public List<Integer> toList() {
        List<Integer> out = new ArrayList<>();
        for (ListNode n = this; n != null; n = n.next) out.add(n.val);
        return out;
    }

    @Override public String toString() { return "ListNode" + toList(); }
}
