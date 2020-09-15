package com.naiofy.pruebas.ventadealbumes.runners;

import com.intuit.karate.KarateOptions;
import com.intuit.karate.Results;
import com.intuit.karate.Runner;
import java.io.File;
import java.util.ArrayList;
import java.util.Collection;
import net.masterthought.cucumber.Configuration;
import net.masterthought.cucumber.ReportBuilder;
import org.apache.commons.io.FileUtils;
import static org.junit.Assert.*;
import org.junit.Test;

@KarateOptions(features = { "src/test/resources/feature/" }, tags = {"~@Invalidar"})
public class EjecutarTodoParaleloRunner {

    @Test
    public void testParallel() {
        String karateOutputPath = "target/reporte";
        Results results = Runner.parallel(getClass(), 3, karateOutputPath);
        generateReport(results.getReportDir());
        assertTrue(results.getErrorMessages(), results.getFailCount()==0);
    }

    public static void generateReport(String karateOutputPath) {
        Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[] {"json"}, true);
        ArrayList jsonPaths = new ArrayList(jsonFiles.size());
        jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));
        Configuration config = new Configuration(new File("target"), "Prueba - Naiofy");
        ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);
        reportBuilder.generateReports();
    }
}
