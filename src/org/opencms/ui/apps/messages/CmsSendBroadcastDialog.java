/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (c) Alkacon Software GmbH & Co. KG (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package org.opencms.ui.apps.messages;

import org.opencms.main.OpenCms;
import org.opencms.ui.A_CmsUI;
import org.opencms.ui.CmsVaadinUtils;
import org.opencms.ui.apps.messages.CmsBroadcastApp.MessageValidator;
import org.opencms.ui.components.CmsBasicDialog;

import java.util.Set;

import com.vaadin.ui.Button;
import com.vaadin.ui.Button.ClickEvent;
import com.vaadin.ui.TextArea;

/**
 * Class for the dialiog to send broadcasts.<p>
 */
public class CmsSendBroadcastDialog extends CmsBasicDialog {

    /**vaadin serial id.*/
    private static final long serialVersionUID = -7642289972554010162L;

    /**cancel button.*/
    private Button m_cancel;

    /**Message text area.*/
    private TextArea m_message;

    /**ok button.*/
    private Button m_ok;

    /**
     * public constructor.<p>
     *
     * @param sessionIds to send broadcast to
     * @param closeRunnable called on cancel
     */
    public CmsSendBroadcastDialog(final Set<String> sessionIds, final Runnable closeRunnable) {
        CmsVaadinUtils.readAndLocalizeDesign(this, CmsVaadinUtils.getWpMessagesForCurrentLocale(), null);

        m_cancel.addClickListener(new Button.ClickListener() {

            private static final long serialVersionUID = 3105449865170606831L;

            public void buttonClick(ClickEvent event) {

                closeRunnable.run();
            }
        });

        m_ok.addClickListener(new Button.ClickListener() {

            private static final long serialVersionUID = -1148041995591262401L;

            public void buttonClick(ClickEvent event) {

                addValidator();
                if (isMessageValid()) {
                    sendBroadcast(sessionIds);
                    closeRunnable.run();
                }
            }
        });
    }

    /**
     * Adds validator to field.<p>
     */
    protected void addValidator() {

        m_message.removeAllValidators();
        m_message.addValidator(new MessageValidator());
    }

    /**
     * Checks if message is valid.<p>
     *
     * @return true if message is valid, false otherwise
     */
    protected boolean isMessageValid() {

        return m_message.isValid();
    }

    /**
     * Sends broadcast.<p>
     *
     * @param sessionIds to send broadcast to
     */
    protected void sendBroadcast(Set<String> sessionIds) {

        if (sessionIds == null) {
            OpenCms.getSessionManager().sendBroadcast(A_CmsUI.getCmsObject(), m_message.getValue());
        } else {
            for (String id : sessionIds) {
                OpenCms.getSessionManager().sendBroadcast(A_CmsUI.getCmsObject(), m_message.getValue(), id);
            }
        }
    }
}
