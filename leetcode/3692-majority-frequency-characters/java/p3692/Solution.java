package p3692;

import java.util.HashMap;
import java.util.List;
import java.util.ArrayList;

class Solution {
    public String majorityFrequencyGroup(String s) {
        int[] charCount = new int[26];

        for (char c : s.toCharArray()) {
            int charNum = (int) c - 97;

            charCount[charNum]++;
        }

        // for (int i : charCount) {
        // System.out.print(i);
        // }
        // System.out.println();

        HashMap<Integer, List<Character>> frequencyMap = new HashMap<>();
        // {2} -> {a, b, c}

        for (int i = 0; i < charCount.length; i++) {
            int curCharCount = charCount[i];

            if (curCharCount == 0)
                continue;

            char currentChar = (char) (i + 97);

            // frequencyMap.computeIfAbsent(curCharCount, k -> new ArrayList<>(List.of(currentChar)));

            if (frequencyMap.containsKey(curCharCount)) {
                frequencyMap.get(curCharCount).add(currentChar);
            } else {
                frequencyMap.put(curCharCount, new ArrayList<>(List.of(currentChar)));
            }
        }

        // System.out.println("initial frequency map:");
        // for (Integer i : frequencyMap.keySet()) {
        //     System.out.println("key: " + i + " value: " + frequencyMap.get(i));
        // }

        int largestGroupSize = 0;

        for (Integer i : frequencyMap.keySet()) {

            if (frequencyMap.get(i).size() > largestGroupSize) {
                largestGroupSize = frequencyMap.get(i).size();
            }
        }

        HashMap<Integer, List<Character>> winnerMap = new HashMap<>();

        for (Integer i : frequencyMap.keySet()) {
            if (frequencyMap.get(i).size() == largestGroupSize) {
                winnerMap.put(i, frequencyMap.get(i));
            }
        }

        // System.out.println("winnerMap:");
        // for (Integer i : winnerMap.keySet()) {
        //     System.out.println("key: " + i + " value: " + frequencyMap.get(i));
        // }

        int largestGroupKey = -1;

        if (winnerMap.size() > 1) {
            for (Integer i : winnerMap.keySet()) {
                if (i > largestGroupKey) {
                    largestGroupKey = i;
                }
            }
        } else {
            largestGroupKey = winnerMap.keySet().iterator().next();
        }

        StringBuilder sb = new StringBuilder();
        for (Character ch : winnerMap.get(largestGroupKey)) {
            sb.append(ch);
        }

        return sb.toString();
    }
}
