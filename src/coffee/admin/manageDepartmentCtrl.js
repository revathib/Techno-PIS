// Generated by CoffeeScript 1.7.1
(function() {
  app.service('departmentService', function($http) {
    this.createNewDept = function(deptName, departmentDescription) {
      console.log('new department added');
      return $http.post(dbServer + '/addDepartment', {
        params: {
          deptName: deptName,
          departmentDescription: departmentDescription
        }
      }).success(function(data, status, headers, config) {
        return data;
      }).error(function(data, status, headers, config) {});
    };
    this.retrieveDepartments = function() {
      console.log("depts");
      return $http.get(dbServer + '/retrieveDepartments').success(function(data, status, headers, config) {
        console.log(data);
        return data;
      }).error(function(data, status, headers, config) {});
    };
    this.retrieveDepartmentById = function(deptId) {
      return $http.get(dbServer + '/retrieveDepartmentsById', {
        params: {
          deptId: deptId
        }
      }).success(function(data, status, headers, config) {
        return data;
      }).error(function(data, status, headers, config) {});
    };
    this.editDepartmentDetails = function(application, deptId) {
      return $http.post(dbServer + 'editDepartments', {
        application: application,
        deptId: deptId
      }).success(function(data, status, headers, config) {
        return data;
      }).error(function(data, status, headers, config) {});
    };
  });

  app.controller('AddDepartmentsCtrl', function($scope, $location, departmentService) {
    return $scope.createNew = function() {
      departmentService.createNewDept($scope.deptName, $scope.departmentDescription).then(function(data) {
        if (data.data.result) {
          return $window.location = '#/adminDepartments';
        }
      });
      return;
      return $location.path('/adminDepartments');
    };
  });

  app.controller('DepartmentsCtrl', function($scope, departmentService) {
    var isPageValid;
    $scope.departments = [];
    departmentService.retrieveDepartments().then(function(data) {
      return $scope.departments = data.data;
    });
    return;
    $scope.pageSize = 5;
    $scope.pageSelected = 0;
    $scope.maxPage = function(departments) {
      if (departments === void 0 || departments.length < $scope.length) {
        return 1;
      }
      return parseInt((departments.length + $scope.pageSize - 1) / $scope.pageSize, 10);
    };
    isPageValid = function(departments, page) {
      return page >= 0 && page < $scope.maxPage(departments);
    };
    return $scope.changePage = function(departments, d) {
      if (isPageValid(departments, $scope.pageSelected + d)) {
        return $scope.pageSelected += d;
      }
    };
  });

  app.filter('paginate', function() {
    return function(arr, pageSize, pageSelected) {
      return arr.slice(pageSize * pageSelected, pageSize * (1 + pageSelected));
    };
  });

}).call(this);

//# sourceMappingURL=manageDepartmentCtrl.map