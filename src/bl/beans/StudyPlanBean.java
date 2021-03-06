package bl.beans;

import org.mongodb.morphia.annotations.Entity;

/**
 * Created by pli on 14-6-29.
 */
@Entity(value = "study_plan")
public class StudyPlanBean extends Bean {
    private String studyId;
    private String startPoint;//随访起点

    public String getStudyId() {
        return studyId;
    }

    public void setStudyId(String studyId) {
        this.studyId = studyId;
    }

    public String getStartPoint() {
        return startPoint;
    }

    public void setStartPoint(String startPoint) {
        this.startPoint = startPoint;
    }
}
