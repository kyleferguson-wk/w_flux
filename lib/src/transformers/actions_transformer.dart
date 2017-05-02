import 'dart:async';

import 'package:analyzer/analyzer.dart';
//import 'package:analyzer/src/generated/ast.dart';
//import 'package:analyzer/src/generated/scanner.dart';
import 'package:barback/barback.dart';
import 'package:code_builder/code_builder.dart';

String src1 = r"""
@ManageActions
class DomActions {
  final Action punch;
  Action hug;
  Action<int> run;
}

@ManageActions
class StephenActions {
  final Action snark;
  Action game;
  Action<int> program;

  StephenActions() {
    print('this is the stephen constructor');
  }
}
""";

class ManagementVisitor extends SimpleAstVisitor<bool> {
  @override
  bool visitAnnotation(Annotation node) {
    return node.name.name == 'ManageActions';
  }

  @override
  bool visitBlock(Block node) {
    for (var child in node.childEntities) {
      print(child.runtimeType);
      print(child.toString());
    }
    return null;
  }

  @override
  bool visitBlockFunctionBody(BlockFunctionBody node) {
    for (var child in node.childEntities) {
      child.accept(this);
    }
    return null;
  }

  @override
  bool visitClassDeclaration(ClassDeclaration node) {
    var shouldManage = node.metadata.any((node) {
      node.accept(this);
    });

    var constructor = node.getConstructor(null);
    if (constructor == null) {
      // We need to add a default constructor.
    } else {
      constructor.accept(this);
    }

    return shouldManage;
  }

  @override
  bool visitCompilationUnit(CompilationUnit node) {
    bool didMakeChanges = false;
    for (var child in node.declarations) {
      if (child is ClassDeclaration) {
        didMakeChanges = child.accept(this) || didMakeChanges;
      }
    }
    return didMakeChanges;
  }

  @override
  bool visitConstructorDeclaration(ConstructorDeclaration node) {
    for (var child in node.childEntities) {
      child.accept(this);
    }
    return null;
  }
}

main() {
  var ast = parseCompilationUnit(src1, parseFunctionBodies: true);
  var visitor = new ManagementVisitor();
  ast.accept(visitor);


  var a = new MethodInvocation(target, operator, methodName, typeArguments, argumentList)


//  List<Identifier> actions = [];
//  ast.declarations.forEach((u) {
//    if (u is ClassDeclaration) {
//      u.metadata.forEach((a) {
//        if (a is Annotation) {
//          if (a.name.toString() == 'ManageActions') {
//            actions.add(u.name);
//          }
//        }
//        if (a is ConstructorDeclaration) {
//        }
//      });
//    }
//  });
//
//  actions.forEach((a) {
//    print(a);
//  });
//
////  print(ast);
////  print(ast.childEntities.first.runtimeType);
//  ast.childEntities.forEach((e) {
//    if (e is AstNode) {
//      print(e.beginToken);
//      e.childEntities.forEach((e) {
//      })
//    }
////    print('$e');
//  });
}

class TransformActions extends Transformer {
  final BarbackSettings _settings;

  TransformActions.asPlugin(this._settings);

  Future apply(Transform transform) async {
    // Skip the transform in debug mode.
    if (_settings.mode.name == 'debug') return null;

    // Apply the transform.
    // ...
    return transform.primaryInput.readAsString().then((src) {
      var ast = parseCompilationUnit(src, parseFunctionBodies: true);
//      var nodes = flatten_tree(ast);
//      var types ={};
//      for(var n in nodes){
//        types[n.runtimeType] ??= [];
//        types[n.runtimeType].add(n);
//      }
//      var data = [];
//      for(var k in types.keys){
//        data.add(k.toString());
//        for(var e in types[k]){
//          data.add('\t'+e.toString());
//        }
//      }
//      data = data.join('\n');
//      print(data);
    });
  }
}