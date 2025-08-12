package com.example.api;

import io.restassured.http.ContentType;
import org.junit.jupiter.api.DynamicTest;
import org.junit.jupiter.api.TestFactory;

import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.nio.file.Path;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.stream.Stream;

import static io.restassured.RestAssured.given;
import static org.hamcrest.Matchers.*;

class ReqresDynamicTest {

    private static class EndpointRow {
        final String name;
        final String method;
        final String url;
        final String bodyFile;
        final int expectedStatus;

        EndpointRow(String name, String method, String url, String bodyFile, int expectedStatus) {
            this.name = name; this.method = method; this.url = url; this.bodyFile = bodyFile; this.expectedStatus = expectedStatus;
        }
    }

    private static List<EndpointRow> readCsv(Path csvPath) throws IOException {
        List<String> lines = Files.readAllLines(csvPath, StandardCharsets.UTF_8);
        List<EndpointRow> rows = new ArrayList<>();
        for (int i = 1; i < lines.size(); i++) { // skip header
            String line = lines.get(i).trim();
            if (line.isEmpty()) continue;
            String[] parts = line.split(",", -1);
            String name = parts[0];
            String method = parts[1];
            String url = parts[2];
            String bodyFile = parts[3].isEmpty() ? null : parts[3];
            int expected = Integer.parseInt(parts[4]);
            rows.add(new EndpointRow(name, method, url, bodyFile, expected));
        }
        return rows;
    }

    @TestFactory
    Stream<DynamicTest> verifyEndpointsFromCsv() throws IOException {
        Path csv = Path.of("tests", "specs", "endpoints.csv");
        List<EndpointRow> endpoints = readCsv(csv);
        return endpoints.stream().map(row -> DynamicTest.dynamicTest(row.name, () -> {
            io.restassured.specification.RequestSpecification spec = given().baseUri(row.url);

            if (row.bodyFile != null) {
                String body = Files.readString(Path.of("tests", "specs", "bodies", row.bodyFile));
                spec = spec.contentType(ContentType.JSON).body(body);
            }

            switch (row.method.toUpperCase()) {
                case "GET":
                    spec.when().get("").then().statusCode(row.expectedStatus);
                    break;
                case "POST":
                    spec.when().post("").then().statusCode(row.expectedStatus);
                    break;
                case "PUT":
                    spec.when().put("").then().statusCode(row.expectedStatus);
                    break;
                case "PATCH":
                    spec.when().patch("").then().statusCode(row.expectedStatus);
                    break;
                case "DELETE":
                    spec.when().delete("").then().statusCode(row.expectedStatus);
                    break;
                default:
                    throw new IllegalArgumentException("Unsupported method: " + row.method);
            }
        }));
    }
}


