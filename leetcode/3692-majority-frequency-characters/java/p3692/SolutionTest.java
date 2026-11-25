package p3692;

import static org.junit.jupiter.api.Assertions.assertEquals;

import java.util.Arrays;

import org.junit.jupiter.api.Test;

class SolutionTest {
    private final Solution solution = new Solution();

    // The problem accepts the characters in any order, so compare sorted.
    private static String sorted(String s) {
        char[] chars = s.toCharArray();
        Arrays.sort(chars);
        return new String(chars);
    }

    private void assertGroup(String expected, String s) {
        assertEquals(sorted(expected), sorted(solution.majorityFrequencyGroup(s)));
    }

    @Test
    void example1() {
        assertGroup("ab", "aaabbbccdddde");
    }

    @Test
    void example2() {
        assertGroup("abcd", "abcd");
    }

    @Test
    void example3() {
        assertGroup("fp", "pfpfgi");
    }

    @Test
    void singleCharacter() {
        assertGroup("a", "a");
    }

    @Test
    void oneLetterRepeated() {
        assertGroup("z", "zzzz");
    }

    @Test
    void biggerGroupBeatsHigherFrequency() {
        assertGroup("bcd", "aaaabcd");
    }

    @Test
    void tieGoesToHigherFrequencyWhenItAppearsLater() {
        assertGroup("cd", "abccdd");
    }

    @Test
    void allTwentySixLettersOnce() {
        assertGroup("abcdefghijklmnopqrstuvwxyz", "abcdefghijklmnopqrstuvwxyz");
    }

    @Test
    void maxLengthSingleLetter() {
        assertGroup("a", "a".repeat(100));
    }
}
