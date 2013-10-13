angular.module \myapp, <[ui.choices]>

myctrl = ($scope) ->
  $scope.transportation = []
  $scope.fruit = []
  $scope.fruit11 =
    multi: true
    value: {}
    data: [
      { name: "Banana", value: 1, fallback: true, btntype: 'btn-primary' },
      { name: "Graphfruit", value: 2, fallback: true },
      { name: "Pitaya", value: 3, fallback: true , active: true }
    ]
