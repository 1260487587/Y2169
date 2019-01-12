package cn.student.entity;

public class Student {
    private Integer stuId;
    private String stuName;
    private Integer stuProId;
    private Integer stuCityId;
    private Integer stuCountyId;
    private String stuPwd;

    public String getStuPwd() {
        return stuPwd;
    }

    public void setStuPwd(String stuPwd) {
        this.stuPwd = stuPwd;
    }

    public Integer getStuId() {
        return stuId;
    }

    public void setStuId(Integer stuId) {
        this.stuId = stuId;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public Integer getStuProId() {
        return stuProId;
    }

    public void setStuProId(Integer stuProId) {
        this.stuProId = stuProId;
    }

    public Integer getStuCityId() {
        return stuCityId;
    }

    public void setStuCityId(Integer stuCityId) {
        this.stuCityId = stuCityId;
    }

    public Integer getStuCountyId() {
        return stuCountyId;
    }

    public void setStuCountyId(Integer stuCountyId) {
        this.stuCountyId = stuCountyId;
    }
}
