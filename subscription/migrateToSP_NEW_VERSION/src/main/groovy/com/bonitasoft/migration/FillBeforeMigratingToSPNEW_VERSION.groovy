/**
 * Copyright (C) 2017 Bonitasoft S.A.
 * BonitaSoft is a trademark of Bonitasoft SA.
 * This software file is BONITASOFT CONFIDENTIAL. Not For Distribution.
 * For commercial licensing information, contact:
 * BonitaSoft, 32 rue Gustave Eiffel – 38000 Grenoble
 * or BonitaSoft US, 51 Federal Street, Suite 305, San Francisco, CA 94107
 **/
package com.bonitasoft.migration

import com.bonitasoft.engine.test.junit.BonitaEngineSPRule
import org.bonitasoft.migration.filler.FillerInitializer
import org.bonitasoft.migration.filler.FillerUtils
import org.junit.Rule

/**
 * @author Emmanuel Duchastenier
 */
class FillBeforeMigratingToSPNEW_VERSION extends org.bonitasoft.migration.FillBeforeMigratingToNEW_VERSION {

    @Rule
    public BonitaEngineSPRule bonitaEngineRule = BonitaEngineSPRule.create().keepPlatformOnShutdown()

    @FillerInitializer
    public void init() {
        FillerUtils.initializeEngineSystemProperties()
    }

}
