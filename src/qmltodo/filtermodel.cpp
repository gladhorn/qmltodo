
#include "filtermodel.h"

#include <Enginio/enginiomodel.h>

#include <qdebug.h>

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
    emit statusFilterChanged();
}

void Filter::updateRoles()
{
    qDebug() << roleNames();
    int statusRole = roleNames().key("status");
    setFilterRole(statusRole);
    setFilterFixedString(m_statusFilter);
}

void Filter::setProperty(int row, const QString &role, const QVariant &value)
{
    QModelIndex proxyIndex = index(row, 0);
    QModelIndex sourceIndex = mapToSource(proxyIndex);
    EnginioModel *model = qobject_cast<EnginioModel*>(sourceModel());
    if (!model) {
        qWarning() << "Invalid model!";
        return;
    }
    model->setProperty(sourceIndex.row(), role, value);
}
