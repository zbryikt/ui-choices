angular.module \ui.choices, <[]>
.directive \choices ($compile) ->
  return
    restrict: 'E'
    replace: true
    transclude: true
    scope: {model: '=ngModel', id: '='}
    template: "<div class='btn-group' ng-transclude></div>"

    link: (s, e, a) ->
      s.type = a[\type]
      update = (s, e, v) ->
        [d,v] = [s.data, (v and s.data[v]) or {}]
        k = [k for k of d]
        if v.fb or (!s.multi and v.e) =>
          k.map -> d[it]on = false
          v.on = true
        else if v.e =>
          k.filter(->d[it]fb)map -> d[it]on = false
          if k.filter(->d[it]on).length==0 =>
            fb = k.filter(->d[it]fb)
            if fb.length => d[fb.0]on = true
        k.map -> 
          if d[it]m => s.$parent[d[it]m] = d[it]on
          if d[it]on => d[it]e.addClass \active
          else d[it]e.removeClass \active
        if s.type == "array" => s.model = k.filter(->d[it]on)map -> d[it]v
        else 
          s.model = {}
          k.map -> s.model[it] = !!d[it]on
      update s, e, null
      
      e.on \update (err,t)->
        update s, e, t
        s.$apply!
      s.$watch \model, (d) ->
        if !d or (!d.length and s.type=="array") => return
        if s.type=="array" => d = ["#{x}" for x in d]
        else d = [k for k of d].filter(-> d[it])
        for k,v of s.data
          if k in d => 
            v.on = true
            v.e.addClass \active
          else 
            v.on = false
            v.e.removeClass \active
          if v.m => s.$parent[v.m] = v.on
      ,true

    controller: ($scope, $element) ->
      $scope.multi = !!($element.attr \multiple)
      $scope.btntype = $element.attr \btn-type
      @node = 
        d: {}
        add: (e,a) ->
          v = a[\value]
          @d[v] = {} <<< {e, v, m: a[\ngModel], fb: a[\fallback]!=undefined, on: a[\active]!=undefined}
        tgl: (v) -> @d[v]on = !@d[v]on
      $scope.data = @node.d
      @is-multi = -> $scope.multi
      @btntype = -> $scope.btntype
      @scope = -> $scope

.directive \choice ($compile) ->
  return
    restrict: 'E'
    transclude: true
    replace: true
    require: "^choices"
    scope: {id: '='}
    template: "<label class='btn'><span ng-transclude></span></label>"
    link: (s, e, a, c) ->
      e.addClass if a[\btnType] => that else if c.btntype! => that else \btn-primary
      c.node.add e, a
      e.on \click -> 
        r = c.node.tgl v = e.attr \value
        setTimeout (-> e.parent!trigger \update, v), 0
 
