<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <style type="text/css">
        .table {
            display: table;
        }

        .table .row2 {
            display: table-row-group;
            background: ghostwhite;
        }

        .table .row1 {
            display: table-row-group;
        }


        .table .cell {
            display: table-cell;
            padding: .5rem;
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
    <form onsubmit="return false">
        <input type="text" name="tempName" placeholder="Name"/>
        <input type="number" name="tempAge" placeholder="Age"/>
        <input type="submit" value="Add" onclick="add()"/>
    </form>
</div>
<form action="${requestScope.contextPath}/doSomething" method="POST" onsubmit="return validate()">
    <div class="table" id="table">
        <div class="header">
            <div style="width: 50px;" class="header-cell">Seq</div>
            <div style="width: 150px;" class="header-cell">Name</div>
            <div style="width: 100px;" class="header-cell">Age</div>
            <div style="width: 100px;" class="header-cell">Action</div>
        </div>
        <c:forEach items="${sessionScope.persons}" var="person" varStatus="vs">
            <div class="row${vs.index % 2 + 1}" id="row${vs.index + 1}">
                <div class="cell">${vs.index + 1}</div>
                <div class="cell">${person.name}</div>
                <div class="cell">${person.age}</div>
                <div class="cell"></div>
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
        var $age = document.querySelector('input[name="tempAge"]')
        var $name = document.querySelector('input[name="tempName"]')
        if (!$age.value || !$name.value) return
        var length = document.querySelectorAll("#table > .row1,.row2").length
        var $table = document.querySelector("#table")
        var template = document.querySelector("#template").innerHTML
        var row = document.createElement("div")
        row.setAttribute("class", "tempRow row" + (length % 2 + 1))
        row.setAttribute("id", "row" + (length + 1))
        row.innerHTML = template.replace(/{([^\\"<>]+)}/ig, function (node, key) {
            return {
                age: $age.value,
                idx: length + 1,
                name: $name.value,
            }[key]
        })
        $table.appendChild(row)
        $name.value = ''
        $age.value = ''
    }

    function deleteRow(index) {
        var $seqColumn = document.querySelectorAll(".seq")
        var $rows = document.querySelectorAll('#table > .tempRow')
        var $row = document.querySelector('#table > #row' + index)
        var $deleteSeqColumn = document.querySelector('#table > #row' + index + ' > .seq')
        $seqColumn.forEach(function(col) {
            if (+col.innerHTML > +$deleteSeqColumn.innerHTML) {
                col.innerHTML = +col.innerHTML - 1
            }
        })
        var flag = false
        $rows.forEach(function(row) {
            if (flag) {
                var cls = row.getAttribute("class")
                var num = +cls.replace('tempRow row', '')
                console.log(cls, num)
                row.setAttribute("class", 'tempRow row' + ((num === 1) ? 2 : 1))
            }
            if ($row === row) {
              flag = true
            }
        })
        $row.remove()
    }
    function validate() {
        var $ages = document.querySelectorAll('input[name=age]')
        var $names = document.querySelectorAll('input[name=name]')
        return !!($ages.length && $names.length)
    }
</script>
<script type="text/html" id="template">
    <div class="cell seq" >{idx}</div>
    <div class="cell">
        {name}
        <input type="hidden" name="name" value="{name}">
    </div>
    <div class="cell">
        {age}
        <input type="hidden" name="age" value="{age}">
    </div>
    <div class="cell">
        <button onclick="deleteRow({idx})" type="button">Delete</button>
    </div>
</script>
</html>
