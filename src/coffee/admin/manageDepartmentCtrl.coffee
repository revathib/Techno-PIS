app.service 'departmentService', ($http) ->

  @createNewDept = (deptName,departmentDescription) ->
    console.log 'new department added'
    $http
    .post(dbServer + '/addDepartment', params : {deptName:deptName,departmentDescription:departmentDescription})
    .success((data, status, headers, config) ->
#      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveDepartments = () ->
    console.log "depts"
    $http
    .get(dbServer+'/retrieveDepartments')
    .success((data,status,headers,config) ->
      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )

  @retrieveDepartmentById = (deptId) ->
    $http
    .get(dbServer + '/retrieveDepartmentsById', params: {deptId:deptId})
    .success((data,status,headers,config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )

  @editDepartmentDetails = (application, deptId) ->
    $http
    .post(dbServer + 'editDepartments', {application:application, deptId:deptId})
    .success((data, status, headers, config) ->
      return data
    )
    .error((data,status,headers,config) ->
    )

  return

app.controller 'AddDepartmentsCtrl', ($scope, $location, departmentService) ->
  $scope.createNew = ->
    departmentService.createNewDept($scope.deptName, $scope.departmentDescription).then (data) ->
      if data.data.result
        $window.location='#/adminDepartments'
    return
    $location.path('/adminDepartments')

app.controller 'DepartmentsCtrl', ($scope, departmentService) ->
  $scope.departments = []
  departmentService.retrieveDepartments().then (data) ->
    $scope.departments = data.data
  return

  $scope.pageSize = 5
  $scope.pageSelected = 0

  $scope.maxPage = (departments)->
    if departments == undefined or departments.length < $scope.length
      return 1
    parseInt( (departments.length + $scope.pageSize - 1)/ $scope.pageSize, 10 )

  isPageValid  = (departments, page) ->
    page >= 0 && page < $scope.maxPage(departments)

  $scope.changePage = (departments, d) ->
    if isPageValid(departments, $scope.pageSelected + d)
      $scope.pageSelected += d

app.filter 'paginate', ->
  (arr, pageSize, pageSelected) ->
    arr.slice pageSize * pageSelected, pageSize * (1 + pageSelected)

#app.controller 'editDepartmentCtrl', ($scope, $param, departmentsService) ->
#  departmentsService.retrieveDepartmentById($param.deptId).then (data) ->
#    $scope.departments = {
#      deptName: data.data.deptName,
#      description: data.data.description
#    }
#    $scope.deptId = data.data.deptId
#  return