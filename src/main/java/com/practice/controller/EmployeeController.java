package com.practice.controller;


import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.tomcat.util.json.JSONParser;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonCreator.Mode;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.practice.util.RestUtil;

@Configuration
@RestController
public class EmployeeController {

    @Autowired
    private RestUtil restUtil;
    
    @GetMapping(value = "/test")
    public String test(){
        return "works";
    }

    @GetMapping(value = "/login")
    public ModelAndView login(){
        return new ModelAndView("login");
    }

    @GetMapping(value = "/registerpage")
    public ModelAndView register(){
        return new ModelAndView("register");
    }

    @PostMapping(value = "/dologin")
    public String dologin(HttpSession session,String username,String password){
        // 
        try{
            Map<String, Object>params = new HashMap<String,Object>();
            params.put("employee_name", username);
            params.put("password", password);
            String details=restUtil.post("http://localhost:5001/employee", params);
            
            JSONObject json = new JSONObject(details);
            if("success".equals(json.getString("status"))){
                JSONObject data = json.getJSONObject("data");
                int employee_id = data.getInt("employee_id");
                session.setAttribute("employee_id",employee_id);
            }
            
            // JSONObject empid = (JSONObject) empdata.get("employee_id");
            //System.out.println(jsonObject);
            // JSONParser par=new JSONParser(details);
            // JSONObject json=(JSONObject)par.parse();
           // System.out.println(jsonObject.getString("data").substring("employee_id"));

           
            // if ("success".equals(jsonObject.get("status"))) {
            //     session.setAttribute("employee_id", employee_id);                
            // }
            return details;
        }
        catch(Exception ex){
            LOGGER.error("details",ex);
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("status", "failure");
            jsonObject.put("message", JSONObject.NULL);
            jsonObject.put("data", "yes");
            return jsonObject.toString();
        }
    }

    @PostMapping(value = "/register/employee")
    public String register(String employee_name,String email,String password){
        try{
            Map<String,Object>params=new HashMap<String,Object>();
            params.put("employee_name", employee_name);
            params.put("email", email);
            params.put("password", password);
            String response=restUtil.post("http://localhost:5001/add/newemployee",params);
            return response.toString();
        }catch(Exception ex){
            LOGGER.error("details",ex);
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("status", "failure");
            jsonObject.put("message", JSONObject.NULL);
            jsonObject.put("data", "yes");
            return jsonObject.toString();
        }
    }

    @GetMapping(value = "/home/{employee_id}")
    public ModelAndView home_page(HttpSession session,@PathVariable("employee_id") Integer employee_id){
        Integer userId=(Integer) session.getAttribute("employee_id");
        if(userId!=null && userId == employee_id){
            return new ModelAndView("/home/{employee_id}");
        }
        return new ModelAndView("redirect:/login");
    }
    private static final Logger LOGGER = LogManager.getLogger(EmployeeController.class);
    
    public static String employeeDetails=null;

    @GetMapping(value = "/getEmployee/Details/{employee_id}")
    public static String getEmployeeDetails(@PathVariable ("employee_id") String employee_id){
        try{
            RestUtil restUtil = new RestUtil();
            Map<String,Object>params=new HashMap<String,Object>();
            employeeDetails=restUtil.get("http://localhost:5001/getEmployee/"+employee_id, params);
            return employeeDetails.toString();
            
        }catch(Exception ex){
            LOGGER.error("details",ex);
            JSONObject jsonObject=new JSONObject();
            jsonObject.put("status", "failure");
            jsonObject.put("message", JSONObject.NULL);
            jsonObject.put("data", "yes");
            return jsonObject.toString();
        }
    }

    public static String getEmployeeDetails(){
        return employeeDetails;
    }

    @GetMapping(value = "/showDetailsPage")
    public ModelAndView showDetailPage(){
        return new ModelAndView("details");
    }
}
