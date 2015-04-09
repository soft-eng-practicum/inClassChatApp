package com.example.CC.test;

import android.test.InstrumentationTestCase;

/**
 * Created by Jack on 4/1/15.
 */
public class UnitTest extends InstrumentationTestCase {

    public void test() throws Exception {
        final int expected = 1;
        final int reality = 5;
        assertEquals(expected, reality);
    }
}
