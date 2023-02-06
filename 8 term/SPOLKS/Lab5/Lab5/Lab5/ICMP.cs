
//////////////////////////////////
class ICMP
{
    public byte Type;
    public byte Code;
    public UInt16 Checksum;
    public short Id;
    public short SequenceNumber;
    public int MessageSize;
    public byte[] Message = new byte[1024];

    public ICMP()
    {
    }

    public ICMP(byte[] data, int size)
    {
        Type = data[20];
        Code = data[21];
        Checksum = BitConverter.ToUInt16(data, 22);
        MessageSize = size - 24;
        Buffer.BlockCopy(data, 24, Message, 0, MessageSize);
    }

    public byte[] getBytes()
    {
        byte[] data = new byte[MessageSize + 8];
        Buffer.BlockCopy(BitConverter.GetBytes((short)Type), 0, data, 0, 1);
        Buffer.BlockCopy(BitConverter.GetBytes((short)Code), 0, data, 1, 1);
        Buffer.BlockCopy(BitConverter.GetBytes(Checksum), 0, data, 2, 2);
        Buffer.BlockCopy(BitConverter.GetBytes(Id), 0, data, 4, 2);
        Buffer.BlockCopy(BitConverter.GetBytes(SequenceNumber), 0, data, 6, 2);
        Buffer.BlockCopy(Message, 0, data, 8, MessageSize);
        return data;
    }

    public UInt16 getChecksum()
    {
        UInt32 chcksm = 0;
        byte[] data = getBytes();
        int packetsize = MessageSize + 8;
        int index = 0;

        while (index < packetsize)
        {
            chcksm += Convert.ToUInt32(BitConverter.ToUInt16(data, index));
            index += 2;
        }
        chcksm = (chcksm >> 16) + (chcksm & 0xffff);
        chcksm += (chcksm >> 16);
        return (UInt16)(~chcksm);
    }
}