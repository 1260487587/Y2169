package cn.student.service;

import cn.student.entity.City;
import cn.student.entity.County;
import cn.student.entity.Province;
import cn.student.entity.Student;
import cn.student.entity.model.StudentModel;

import java.util.List;

public interface IStudentService {
    public Student doLogin(String stuName, String stuPwd) throws Exception;

    public List<StudentModel> getOnePageData(String stuPwd) throws Exception;

    public List<Province> loadProvince() throws Exception;

    public List<City> loadCity(int proId) throws Exception;

    public List<County> loadCounty(int cityId) throws Exception;

    public int addStudent(Student student) throws Exception;

    public int checkStuName(Student student) throws Exception;
}
