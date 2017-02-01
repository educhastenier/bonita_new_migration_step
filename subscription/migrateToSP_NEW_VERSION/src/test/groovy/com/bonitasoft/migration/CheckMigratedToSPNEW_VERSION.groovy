/**
 * Copyright (C) 2017 Bonitasoft S.A.
 * BonitaSoft is a trademark of Bonitasoft SA.
 * This software file is BONITASOFT CONFIDENTIAL. Not For Distribution.
 * For commercial licensing information, contact:
 * BonitaSoft, 32 rue Gustave Eiffel – 38000 Grenoble
 * or BonitaSoft US, 51 Federal Street, Suite 305, San Francisco, CA 94107
 **/
package com.bonitasoft.migration

import com.bonitasoft.engine.api.APIClient
import com.bonitasoft.engine.test.junit.BonitaEngineSPRule
import org.bonitasoft.migration.CheckMigratedToNEW_VERSION
import org.bonitasoft.migration.filler.FillerUtils
import org.junit.BeforeClass
import org.junit.Rule

/**
 * @author Emmanuel Duchastenier
 */
class CheckMigratedToSPNEW_VERSION extends CheckMigratedToNEW_VERSION {

    @Rule
    public BonitaEngineSPRule bonitaEngineRule = BonitaEngineSPRule.create().reuseExistingPlatform()

    @BeforeClass
    public static void beforeClass() {
        FillerUtils.initializeEngineSystemProperties()
    }

    def "verify we can login on migrated SP platform"() {
        given:
        def client = new APIClient()
 
        when:
        client.login("install", "install")
 
        then:
        client.session != null
    }
}
