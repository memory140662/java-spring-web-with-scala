package tw.com.demo.controller

import java.util

import javax.servlet.http.{HttpServletRequest, HttpSession}
import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.{GetMapping, PostMapping, SessionAttributes}
import tw.com.demo.bean.Person

@Controller
@SessionAttributes(value = Array("persons", "message"))
class MyController {


  @GetMapping(Array("/"))
  def index(model: Model): String = {
    model addAttribute("message", "Hello World")
    "index"
  }

  @PostMapping
  def doSomething(request: HttpServletRequest, model: Model): String = {
    var persons: util.ArrayList[Person] = (request.getSession getAttribute "persons").asInstanceOf[util.ArrayList[Person]]
    val names: Array[String] = request getParameterValues "name"
    val ages: Array[String] = request getParameterValues "age"

    if (names == null || ages == null)
      return "index"

    if (persons == null) {
      persons = new util.ArrayList[Person]()
    }

    for (idx <- names indices) {
      val name: String = if (idx < names.length) names(idx) else null
      val age: Integer = if (idx < ages.length) ages(idx).toInt else null
      persons add new Person(name, age)
    }
    model addAttribute("persons", persons)
    "index"
  }
}

