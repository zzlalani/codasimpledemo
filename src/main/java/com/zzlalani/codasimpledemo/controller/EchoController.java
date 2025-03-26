package com.zzlalani.codasimpledemo.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api")
public class EchoController {

    private static final Logger logger = LoggerFactory.getLogger(EchoController.class);

    @Value("${server.port}")
    private String serverPort;

    @PostMapping("/echo")
    public ResponseEntity<Object> echo(@RequestBody Object payload) {
        logger.info("Received request on port {}: {}", serverPort, payload);
        return ResponseEntity.ok(payload);
    }

    @GetMapping("/data")
    public ResponseEntity<Object> test() {
        logger.info("Received request on port {}", serverPort);
        return ResponseEntity.ok("Test successful");
    }

}
