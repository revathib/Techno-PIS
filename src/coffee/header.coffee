app.service 'headerService',($http)->
  this.retrievePrivileges=(user)->
    $http
    .get(dbServer+'/retrievePrivileges',params : {user:user})
    .success((data,status,headers,config)->
      return  data
    )
    .error((data,status,headers,config)->
    )

  return

app.controller 'HeaderCtrl', ($scope,$window,headerService)->
  headerService.retrievePrivileges($.cookie("user")).then (data)->
    console.log data
    $scope.user = data.data
    $scope.user.username = $.cookie("userName")

    console.log $scope.user
