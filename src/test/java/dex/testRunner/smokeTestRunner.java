package dex.testRunner;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import dex.util.TestUtil;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class smokeTestRunner {
    @Test
    void dexAPISmokeTest() {
        Results results = Runner.path("classpath:dex/feature").tags("@smoke").outputCucumberJson(true).parallel(1);
        TestUtil.generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
