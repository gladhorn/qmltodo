
#include "filtermodel.h"


void Filter::setSourceModel(QAbstractItemModel *arg)
{
    QSortFilterProxyModel::setSourceModel(arg);
    connect(arg, SIGNAL(headerDataChanged(Qt::Orientation,int,int)), this, SLOT(updateRoles()));
    connect(arg, SIGNAL(modelReset()), this, SLOT(updateRoles()));

//    int statusRole = roleNames().key("status");
//    setFilterRole(statusRole);
//    emit sourceModelChanged();
//    setFilterRole(262);
//    setFilterFixedString(QString());
}

QAbstractItemModel *Filter::sourceModel() const
{
    return QSortFilterProxyModel::sourceModel();
}

void Filter::setStatusFilter(const QString &filter)
{
    if (m_statusFilter == filter)
        return;
    m_statusFilter = filter;
//    setFilterFixedString(filter);
    emit statusFilterChanged();
}

#include <qdebug.h>

void Filter::updateRoles()
{
    qDebug() << roleNames();
    int statusRole = roleNames().key("status");
    setFilterRole(statusRole);
    setFilterFixedString(m_statusFilter);
}

