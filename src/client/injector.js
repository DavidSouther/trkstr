var _module = angular.module;
angular.module = function(name, dependencies){
  var module = null;
  if(!(dependencies instanceof Array)){
    return _module.call(null, name); // Just the getter
  };

  dependencies.push('songFlux');
  module = _module.call(null, name, dependencies) // A new module

  module.action = module.action || function(ActionCtor){
    ActionFactory.$inject = [ 'songFactory' ];
    function ActionFactory(song){
      ActionCtor.prototype.getDispatcher = function(){
        this.dispatcher = this.dispatcher || song.getDispatcher(this.module);
        return this.dispatcher;
      };
      ActionCtor.prototype.dispatch = function(){
        this.getDispatcher().dispatch(this);
        this.dispatcher.dispatch(this);
      };
      return ActionCtor;
    }
    module.factory(ActionCtor.name, ActionFactory);
    return module;
  };

  module.component = module.component || function(name, ComponentCtor){
    module.directive(name, function(){
      var directive = new ComponentCtor();

      directive.scope = directive.scope || {};
      directive.restrict = directive.restrict || 'EA';


      directive.replace = false;
      directive.controllerAs = 'state';
      directive.bindToController = true;

      return directive;
    });


    return module;
  }

  return module;
};
