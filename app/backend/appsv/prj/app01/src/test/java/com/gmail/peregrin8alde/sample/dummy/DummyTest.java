package com.gmail.peregrin8alde.sample.dummy;

import static org.junit.Assert.assertEquals;
import org.junit.Test;

public class DummyTest {
    @Test
    public void evaluatesExpression() {
      Dummy target = new Dummy();

      String message = target.massage();
      assertEquals("dummy message", message);
    }
}
