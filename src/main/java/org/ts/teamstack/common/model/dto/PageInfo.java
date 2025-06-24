package org.ts.teamstack.common.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.springframework.stereotype.Component;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Component
public class PageInfo {
    private int curPage = 1;
    private int numPerpage=5;
    private int totalData;
    private int pageBarSize = 5;
}
