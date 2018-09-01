package tw.com.demo.controller

import org.springframework.stereotype.Controller
import org.springframework.ui.Model
import org.springframework.web.bind.annotation.PostMapping
import org.springframework.web.bind.annotation.RequestMapping

@Controller class HelloController  {

  @RequestMapping(Array("/"))
  def index(model: Model): String = {
    model.addAttribute("message", "Hello World")
    "index"
  }

  @PostMapping
  def doSomething(name: String, age: Int, model: Model) = {
    model.addAttribute("name", name)
    model.addAttribute("age", age)
    "index"
  }
}

