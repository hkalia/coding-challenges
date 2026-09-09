package p1450;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

class SolutionTest {
    private final Solution solution = new Solution();

    @Test
    void example1() {
        assertEquals(1, solution.busyStudent(new int[] {1, 2, 3}, new int[] {3, 2, 7}, 4));
    }

    @Test
    void example2() {
        assertEquals(1, solution.busyStudent(new int[] {4}, new int[] {4}, 4));
    }

    @Test
    void queryOnStartBoundaryCounts() {
        assertEquals(1, solution.busyStudent(new int[] {5}, new int[] {9}, 5));
    }

    @Test
    void queryOnEndBoundaryCounts() {
        assertEquals(1, solution.busyStudent(new int[] {5}, new int[] {9}, 9));
    }

    @Test
    void nobodyBusy() {
        assertEquals(0, solution.busyStudent(new int[] {1, 1, 1}, new int[] {2, 2, 2}, 5));
    }

    @Test
    void everybodyBusy() {
        assertEquals(3, solution.busyStudent(new int[] {1, 2, 3}, new int[] {10, 10, 10}, 4));
    }
}
