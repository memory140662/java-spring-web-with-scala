<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<body>
<h2>Hello World!</h2>

<form action="${requestScope.contextPath}/doSomething" method="POST">
    <input type="text" name="name" value="${name}">
    <input type="number" name="age" value="${age}"/>
    <input type="submit" />
</form>


</body>
</html>
