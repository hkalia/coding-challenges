package p1450;

class Solution {
    public int busyStudent(int[] startTime, int[] endTime, int queryTime) {
        int numOfBusyStudents = 0;

        for (int i = 0; i < endTime.length; i++) {
            if (startTime[i] <= queryTime && endTime[i] >= queryTime) {
                numOfBusyStudents++;
            }
        }

        return numOfBusyStudents;
    }
}
