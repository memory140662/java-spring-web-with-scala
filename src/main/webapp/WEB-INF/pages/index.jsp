<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <style type="text/css">
        .table {
            display: table;
        }

        .table .row {
            display: table-row-group
        }

        .row .cell1 {
            display: table-cell;
            padding: .5rem;
        }

        .row .cell2 {
            display: table-cell;
            padding: .5rem;
            background: ghostwhite;
        }

        .table .header {
            display: table-header-group;
        }

        .header .header-cell {
            display: table-cell;
            text-align: center;
        }

    </style>
</head>
<body>
<h2>${message}</h2>
<div>
    <input type="text" name="name" placeholder="Name"/>
    <input type="number" name="age" placeholder="Age"/>
    <input type="button" value="Add" onclick="add()"/>
</div>
<form action="${requestScope.contextPath}/doSomething" method="POST">
    <div class="table" id="table">
        <div class="header">
            <div style="width: 50px;" class="header-cell">Seq</div>
            <div style="width: 150px;" class="header-cell">Name</div>
            <div style="width: 100px;" class="header-cell">Age</div>
            <div style="width: 100px;" class="header-cell">Action</div>
        </div>
        <c:forEach items="${sessionScope.persons}" var="person" varStatus="vs">
            <div class="row" id="row${vs.index + 1}">
                <div class="cell${vs.index % 2 + 1}">${vs.index + 1}</div>
                <div class="cell${vs.index % 2 + 1}">${person.name}</div>
                <div class="cell${vs.index % 2 + 1}">${person.age}</div>
                <div class="cell${vs.index % 2 + 1}"></div>
            </div>
        </c:forEach>
    </div>
    <div>
        <button type="submit">Save</button>
    </div>
</form>
</body>
<script>
    function add() {
        var $age = document.querySelector('input[name="age"]')
        var $name = document.querySelector('input[name="name"]')
        if (!$age.value || !$name.value) return
        var length = document.querySelectorAll("#table > .row").length
        var $table = document.querySelector("#table")
        var template = document.querySelector("#template").innerHTML
        var row = document.createElement("div")
        row.setAttribute("class", "row")
        row.setAttribute("id", "row" + (length + 1))
        row.innerHTML = template.replace(/{([^\\"<>]+)}/ig, function (node, key) {
            return {
                age: $age.value,
                idx: length + 1,
                num: length % 2 + 1,
                name: $name.value,
            }[key]
        })
        $table.appendChild(row)
        $name.value = ''
        $age.value = ''
    }

    function deleteRow(index) {
        var $seqColumn = document.querySelectorAll(".seq")
        var $row = document.querySelector('#table > #row' + index)
        var $deleteSeqColumn = document.querySelector('#table > #row' + index + ' > .seq')
        $seqColumn.forEach(function(col) {
            if (+col.innerHTML > +$deleteSeqColumn.innerHTML) {
                col.innerHTML = +col.innerHTML - 1
            }
        })
        $row.remove()

    }
</script>
<script type="text/html" id="template">
    <div class="cell{num} seq" >{idx}</div>
    <div class="cell{num}">
        {name}
        <input type="hidden" name="name" value="{name}">
    </div>
    <div class="cell{num}">
        {age}
        <input type="hidden" name="age" value="{age}">
    </div>
    <div class="cell{num}">
        <button onclick="deleteRow({idx})" type="button">Delete</button>
    </div>
</script>
</html>
