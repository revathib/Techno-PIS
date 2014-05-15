app.controller 'addEmpCtrl', ($scope,$http,$window)->
  console.log('addEmpCtrl');
  $scope.submit = ()->
    console.log('submit');
#    $http
#    .post('http://192.168.0.174:1235/login',$scope.user)
#    .success((data,status,headers,config)->
#        if data.result == true
#          $.cookie("user", data.token);
#    $window.location='#/addEmployee'
#        else
#          $scope.error=true;
#          $.removeCookie("user");
#      )
#    .error((data,status,headers,config)->
#        $scope.error=true;
#        $.removeCookie("user");
#      )
#    return
#  return


