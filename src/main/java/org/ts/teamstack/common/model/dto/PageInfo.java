package org.ts.teamstack.common.model.dto;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.ibatis.session.RowBounds;
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
    public void initialize(){
        this.curPage = 1;
        this.numPerpage = 5;
        this.pageBarSize = 5;
    }
    public RowBounds getRowBounds() {
        return new RowBounds((this.curPage - 1) * this.getNumPerpage(), this.numPerpage);
    }
}

