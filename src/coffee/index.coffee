
app.service 'userService',($http)->
  @validate=(user)->
    $http
      .post(dbServer+'/login',user)
      .success((data,status,headers,config)->
          data.result
        )
      .error((data,status,headers,config)->
        )
  return


app.controller 'LoginCtrl', ($scope,$window,userService)->
  $scope.user={}
  $scope.user.rememberme=false;
  $scope.submit = ()->
    userService.validate($scope.user).then (data)->
      if data.data.result == true
        if $scope.user.rememberme
          $.cookie("user", data.data.user, { expires: 1 });
          $.cookie("userName", data.data.userName, { expires: 1 });
          $.cookie("manager", data.data.manager, { expires: 1 });
        else
          $.cookie("user", data.data.user);
          $.cookie("userName", data.data.userName);
          $.cookie("manager", data.data.manager);
        $window.location='#/dashboard'
        return
      else if data.data.result == false
        $scope.passwordError=false;
        $scope.error=true;
        $('#username').val('')
        $('#username').focus()
        $('#password').val('')
        return
      else if data.data.result == "passwordError"
        $scope.error=false;
        $scope.passwordError=true;
        $('#password').val('')
        $('#password').focus()
        return

    return
  return


