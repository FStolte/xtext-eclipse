package org.eclipse.xtext.example.domainmodel.tests

import com.google.common.base.Supplier
import com.google.inject.Inject
import com.google.inject.Provider
import org.eclipse.xtext.example.domainmodel.domainmodel.DomainModel
import org.eclipse.xtext.generator.InMemoryFileSystemAccess
import org.eclipse.xtext.junit4.InjectWith
import org.eclipse.xtext.junit4.XtextRunner
import org.eclipse.xtext.junit4.util.ParseHelper
import org.eclipse.xtext.junit4.validation.ValidationTestHelper
import org.eclipse.xtext.xbase.compiler.JvmModelGenerator
import org.eclipse.xtext.xbase.compiler.OnTheFlyJavaCompiler$EclipseRuntimeDependentJavaCompiler
import org.eclipse.xtext.xbase.junit.evaluation.AbstractXbaseEvaluationTest
import org.eclipse.xtext.xbase.lib.Functions
import org.junit.Before
import org.junit.Ignore
import org.junit.Test
import org.junit.runner.RunWith

/**
 * Xbase integration test.
 * 
 * runs all Xbase tests from {@link AbstractXbaseEvaluationTest} in the context of an
 * entity operation.
 * 
 * Unsupported features can be disabled by overriding the respective test method.
 * 
 * @author Sven Efftinge
 */
@RunWith(typeof(XtextRunner))
@InjectWith(typeof(InjectorProviderCustom))
public class XbaseIntegrationTest extends AbstractXbaseEvaluationTest {

	@Inject EclipseRuntimeDependentJavaCompiler javaCompiler

	@Inject ParseHelper<DomainModel> parseHelper

	@Inject ValidationTestHelper validationHelper
	
	@Inject JvmModelGenerator generator
	
	@Before
	def void initializeClassPath(){
		javaCompiler.addClassPathOfClass(getClass()) // this bundle
		javaCompiler.addClassPathOfClass(typeof(AbstractXbaseEvaluationTest)) // xbase.junit
		javaCompiler.addClassPathOfClass(typeof(Functions)) // xbase.lib
		javaCompiler.addClassPathOfClass(typeof(Provider))  // google guice
		javaCompiler.addClassPathOfClass(typeof(Supplier))  // google collect
		javaCompiler.addClassPathOfClass(typeof(javax.inject.Inject))  // javax inject
	}

	protected def invokeXbaseExpression(String expression) {
		val parse = parseHelper.parse("entity Foo { op doStuff() : Object { "+expression+" } } ")
		validationHelper.assertNoErrors(parse)
		val fsa = new InMemoryFileSystemAccess()
		generator.doGenerate(parse.eResource(), fsa)
		val concatenation = fsa.getFiles().values().iterator().next()
		val clazz = javaCompiler.compileToClass("Foo", concatenation.toString())
		val foo = clazz.newInstance()
		val method = clazz.getDeclaredMethod("doStuff")
		method.invoke(foo)
	}
	
	@Test
	@Ignore
	override testImplicitOneArgClosure_01() {
		super.testImplicitOneArgClosure_01()
	}
	
}