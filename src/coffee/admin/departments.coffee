app.service 'getDepartments', ($http) ->
  @retrieveDepartments = () ->
    $http
    .get(dbServer+'/retrieveDepartments')
    .success((data,status,headers,config) ->
      console.log data
      return data
    )
    .error((data,status,headers,config) ->
    )
  return

app.controller 'DepartmentsCtrl', ($scope, getDepartments) ->
  $scope.departments = []
  getDepartments.retrieveDepartments().then (data) ->
    $scope.departments = data.data
  return