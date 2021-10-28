package dex.testRunner;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import dex.util.TestUtil;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class testRunner {
    @Test
    void dexAPIRegTest() {
        Results results = Runner.path("classpath:dex/feature").tags("~@ignore").outputCucumberJson(true).parallel(1);
        TestUtil.generateReport(results.getReportDir());
        assertEquals(0, results.getFailCount(), results.getErrorMessages());
    }
}
