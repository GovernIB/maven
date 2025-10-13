package es.caib.maven.artifacts.enforcer.rules;

import org.apache.maven.enforcer.rule.api.EnforcerRule;
import org.apache.maven.enforcer.rule.api.EnforcerRuleException;
import org.apache.maven.enforcer.rule.api.EnforcerRuleHelper;
import org.apache.maven.project.MavenProject;
import org.apache.maven.model.Dependency;

/**
 * 
 * @author anadal
 * 7 oct 2025 10:22:55
 */
@SuppressWarnings("deprecation")
public class EnforceDependencyVersionConsistencyRule implements EnforcerRule {

    @Override
    public void execute(EnforcerRuleHelper helper) throws EnforcerRuleException {
        try {
            MavenProject project = (MavenProject) helper.evaluate("${project}");

            if (project.getDependencies() == null || project.getDependencyManagement() == null
                    || project.getDependencyManagement().getDependencies() == null) {
                return;
            }

            for (Dependency dep : project.getDependencies()) {
                for (Dependency managed : project.getDependencyManagement().getDependencies()) {
                    if (dep.getGroupId().equals(managed.getGroupId())
                            && dep.getArtifactId().equals(managed.getArtifactId())) {

                        String v1 = dep.getVersion();
                        String v2 = managed.getVersion();
                        if (v1 != null && v2 != null && !v1.equals(v2)) {
                            throw new EnforcerRuleException(
                                    "Dependencia '" + dep.getGroupId() + ":" + dep.getArtifactId() + "' usa versión "
                                            + v1 + " distinta de la definida en dependencyManagement (" + v2 + ")");
                        }
                    }
                }
            }
        } catch (Exception e) {
            throw new EnforcerRuleException("Error verificando versiones de dependencias: " + e.getMessage(), e);
        }
    }

    @Override
    public String getCacheId() {
        return null;
    }

    @Override
    public boolean isCacheable() {
        return false;
    }

    @Override
    public boolean isResultValid(EnforcerRule rule) {
        return false;
    }
}
