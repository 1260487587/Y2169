package cn.student.controller;

import cn.student.entity.City;
import cn.student.entity.County;
import cn.student.entity.Province;
import cn.student.entity.Student;
import cn.student.entity.model.StudentModel;
import cn.student.service.IStudentService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class StudentController {
    @Autowired
    private IStudentService service;

    /**
     * 登录
     *
     * @param stuName
     * @param stuPwd
     * @param session
     * @return
     * @throws Exception
     */
    @RequestMapping("/doLogin")
    @ResponseBody
    public Object doLogin(String stuName, String stuPwd, HttpSession session) throws Exception {
        Student student = service.doLogin(stuName, stuPwd);
        if (student != null) {
            session.setAttribute("student", student);
            return 1;
        } else {
            return 2;
        }
    }

    /**
     * 分页查询方法
     *
     * @param pageIndex
     * @param stuName
     * @return
     * @throws Exception
     */
    @RequestMapping("/getOnePageData")
    @ResponseBody
    public Object getOnePageData(Integer pageIndex, String stuName) throws Exception {
        PageHelper.startPage(pageIndex, 3);
        List<StudentModel> onePageData = service.getOnePageData(stuName);
        PageInfo<StudentModel> info = new PageInfo<StudentModel>(onePageData);
        return info;
    }

    @RequestMapping("/toRegister")
    public String toRegister() {
        return "register";
    }

    @RequestMapping("/loadProvince")
    @ResponseBody
    public Object loadProvince() throws Exception {
        List<Province> provinces = service.loadProvince();
        return provinces;
    }

    @RequestMapping("/loadCity")
    @ResponseBody
    public Object loadCity(int proId) throws Exception {
        List<City> cities = service.loadCity(proId);
        return cities;
    }

    @RequestMapping("/loadCounty")
    @ResponseBody
    public Object loadCounty(int cityId) throws Exception {
        List<County> counties = service.loadCounty(cityId);
        return counties;
    }

    @RequestMapping("/addStudent")
    public String addStudent(Student student, HttpServletRequest request, RedirectAttributes attributes) throws Exception {
        int i = service.checkStuName(student);
        if (i > 0) {
            request.setAttribute("msg", "用户名已注册");
            return "redirect:/toRegister";
        }
        int count = service.addStudent(student);
        if (i > 0) return "login";
        else return "redirect:/toRegister";
    }
}
