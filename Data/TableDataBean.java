package WebLab.Data;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Objects;

public class TableDataBean implements Serializable {
    private double x;
    private double y;
    private double r;
    private String result;
    private LocalDateTime current_time ;
    private double processing_time ;

    public TableDataBean() {

    }

    public TableDataBean(double x, double y, double r, String result, LocalDateTime current_time, double processing_time) {
        this.x = x;
        this.y = y;
        this.r = r;
        this.result = result;
        this.current_time = current_time;
        this.processing_time = processing_time;
    }

    public double getX() {
        return x;
    }

    public double getY() {
        return y;
    }

    public double getR() {
        return r;
    }

    public String getResult() {
        return result;
    }

    public LocalDateTime getCurrentTime() {
        return current_time;
    }

    public double getProcessingTime() {
        return processing_time;
    }

    public void setX(double x) {
        this.x = x;
    }

    public void setY(double y) {
        this.y = y;
    }

    public void setR(double r) {
        this.r = r;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public void setCurrent_time(LocalDateTime current_time) {
        this.current_time = current_time;
    }

    public void setProcessing_time(double processing_time) {
        this.processing_time = processing_time;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        TableDataBean that = (TableDataBean) o;
        return Double.compare(that.x, x) == 0 && Double.compare(that.y, y) == 0 && Double.compare(that.r, r) == 0 && Double.compare(that.processing_time, processing_time) == 0 && result.equals(that.result) && current_time.equals(that.current_time);
    }

    @Override
    public int hashCode() {
        return Objects.hash(x, y, r, result, current_time, processing_time);
    }
}
