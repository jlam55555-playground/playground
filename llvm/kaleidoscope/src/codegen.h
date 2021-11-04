#ifndef KALEIDOSCOPE_CODEGEN_HPP
#define KALEIDOSCOPE_CODEGEN_HPP

#include <llvm/IR/IRBuilder.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include <llvm/IR/Value.h>
#include <map>
#include <memory>
#include <string>

extern llvm::LLVMContext TheContext;
extern llvm::IRBuilder<> Builder;
extern std::unique_ptr<llvm::Module> TheModule;
extern std::map<std::string, llvm::Value *> NamedValues;

llvm::Value *LogErrorV(const char *Str);

#endif
