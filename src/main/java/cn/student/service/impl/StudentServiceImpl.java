package cn.student.service.impl;

import cn.student.dao.IStudentDAO;
import cn.student.entity.City;
import cn.student.entity.County;
import cn.student.entity.Province;
import cn.student.entity.Student;
import cn.student.entity.model.StudentModel;
import cn.student.service.IStudentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StudentServiceImpl implements IStudentService {
    @Autowired
    private IStudentDAO dao;

    @Override
    public Student doLogin(String stuName, String stuPwd) throws Exception {
        return dao.doLogin(stuName, stuPwd);
    }

    @Override
    public List<StudentModel> getOnePageData(String stuPwd) throws Exception {
        return dao.getOnePageData(stuPwd);
    }

    @Override
    public List<Province> loadProvince() throws Exception {
        return dao.loadProvince();
    }

    @Override
    public List<City> loadCity(int proId) throws Exception {
        return dao.loadCity(proId);
    }

    @Override
    public List<County> loadCounty(int cityId) throws Exception {
        return dao.loadCounty(cityId);
    }

    @Override
    public int addStudent(Student student) throws Exception {
        return dao.addStudent(student);
    }

    @Override
    public int checkStuName(Student student) throws Exception {
        return dao.addStudent(student);
    }
}
