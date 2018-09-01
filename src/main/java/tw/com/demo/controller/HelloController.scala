package tw.com.demo.controller

import java.util
import java.util.ArrayList

import javax.servlet.http.{HttpServletRequest, HttpSession}
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.{PostMapping, RequestMapping, SessionAttributes}
import tw.com.demo.bean.Person

@Controller
@SessionAttributes(value = Array("persons", "message"))
class HelloController  {


  @RequestMapping(Array("/"))
  def index(model: Model): String = {
    model.addAttribute("message", "Hello World")
    "index"
  }

  @PostMapping
  def doSomething(request: HttpServletRequest, model: Model, httpSession: HttpSession): String = {
    var persons: util.ArrayList[Person] = (httpSession getAttribute "persons").asInstanceOf[ArrayList[Person]]
    val names: Array[String] = request getParameterValues "name"
    val ages: Array[String] = request getParameterValues "age"
    if (persons == null)
      persons = new util.ArrayList[Person]()
    for (idx <- names indices) {
      val name: String = names(idx)
      val age: Int = ages(idx).toInt
      persons add new Person(name, age)
    }
    model addAttribute("persons", persons)
    "index"
  }
}

