package org.ts.teamstack.common.controller;

import java.sql.Timestamp;
import java.time.LocalDateTime;

public class DateParser {
    public static LocalDateTime TimestampToLocalDateTime(Timestamp timestamp) {
        if (timestamp == null) return null;
        return timestamp.toLocalDateTime();
    }
}
